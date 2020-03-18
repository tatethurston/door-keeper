namespace :assets do
  task :precompile do
    `./scripts/build-frontend`
  end
end
