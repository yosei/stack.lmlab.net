json.array!(@stacks) do |stack|
  json.extract! stack, :id, :title, :content, :url1, :url2, :url3, :picture1, :picture2, :picture3
  json.url stack_url(stack, format: :json)
end
