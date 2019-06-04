module Comments
  class Presenter < BasePresenter
    def all_fields
      {
        id: object.id,
        post_id: object.post_id,
        content: object.content,
        commentable_type: humanize_class_name(object.commentable_type),
        commentable_id: object.commentable_id
      }
    end

    def build(*object_fields)
      {
        comment: super
      }
    end

    private

    def humanize_class_name(class_name)
      class_name.split("::").first.singularize.downcase
    end
  end
end
