json.array!(@bowls) do |bowl|
  json.extract! bowl, :id
  json.url bowl_url(bowl, format: :json)
end
