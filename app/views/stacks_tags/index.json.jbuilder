json.array!(@stacks_tags) do |stacks_tag|
  json.extract! stacks_tag, :id, :stack_id, :name
  json.url stacks_tag_url(stacks_tag, format: :json)
end
