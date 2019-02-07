class TasksController < ActionController::Base
  include ActionController::Live

  def perform
    response.headers["Content-Type"] = "text/event-stream"
    perform_task(response.stream)
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
end
