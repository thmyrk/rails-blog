class PostsRepository < BaseRepository
  def find_with_comments(id)
    gateway.where(id: id).includes(:comments).first
  end
end
