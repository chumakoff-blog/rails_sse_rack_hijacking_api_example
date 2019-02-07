class TasksHijackController < ActionController::Base
  def full_hijack
    request.env['rack.hijack'].call
    stream = request.env['rack.hijack_io']

    send_headers(stream)

    Thread.new do
      perform_task(stream)
    end

    response.close
  end

  def partial_hijack
    response.headers["Content-Type"] = "text/event-stream"

    response.headers["rack.hijack"] = proc do |stream|
      Thread.new do
        perform_task(stream)
      end
    end

    head :ok
  end

  private

  def perform_task(stream)
    sse = ActionController::Live::SSE.new(stream, retry: 300, event: "taskProgress")

    task_progress = 0 # progress percentage

    while task_progress < 100 do
      task_progress += 5
      sse.write(progress: task_progress)
      sleep 1
    end
  ensure
    sse.close
  end

  def send_headers(stream)
    headers = [
      "HTTP/1.1 200 OK",
      "Content-Type: text/event-stream"
    ]
    stream.write(headers.map { |header| header + "\r\n" }.join)
    stream.write("\r\n")
    stream.flush
  rescue
    stream.close
    raise
  end
end
