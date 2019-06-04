REPOSITORIES = {
  posts: PostsRepository.new(gateway: Posts::Model),
  comments: CommentsRepository.new(gateway: Comments::Model)
}.freeze
