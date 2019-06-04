module Posts
  class Presenter < BasePresenter
    def all_fields
      {
        id: object.id,
        title: object.title,
        content: object.content
      }
    end

    def build(*object_fields)
      {
        post: super
      }
    end
  end
end
