json.array!(@questions) do |question|
  json.extract! question, :id, :theme_id, :title, :points, :problem_statement, :answer, :explanation
  json.url question_url(question, format: :json)
end
