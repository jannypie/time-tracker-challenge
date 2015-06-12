json.projects do
  json.array! @projects, partial: 'projects/project', as: :project
end
