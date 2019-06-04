class RepositoryRegistry
  RepositoryNotFound = Class.new(StandardError)

  def self.for(type)
    repositories.fetch(type) do
      raise(RepositoryNotFound, "Repository #{type} not registered")
    end
  end

  def self.repositories
    REPOSITORIES # defined in config/initializers/repositories.rb
  end

  private_class_method :repositories

  private

  def initialize(*)
    raise "Should not be initialiazed"
  end
end
