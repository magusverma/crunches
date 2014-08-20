json.array!(@themes) do |theme|
  json.extract! theme, :id, :name, :details, :database_url
  json.url theme_url(theme, format: :json)
end
