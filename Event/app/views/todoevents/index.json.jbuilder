json.array!(@todoevents) do |todoevent|
  json.extract! todoevent, :id
  json.url todoevent_url(todoevent, format: :json)
end
