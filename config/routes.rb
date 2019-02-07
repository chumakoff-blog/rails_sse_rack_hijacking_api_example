Rails.application.routes.draw do
  root to: "home#index"

  get "ac_live" => "tasks#perform"
  get "full_hijack" => "tasks_hijack#full_hijack"
  get "partial_hijack" => "tasks_hijack#partial_hijack"
end
