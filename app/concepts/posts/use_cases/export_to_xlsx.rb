module Posts
  module UseCases
    class ExportToXlsx < BaseUseCase
      def call
        post = RepositoryRegistry.for(:posts).find_with_comments(params[:id])

        create_spreadsheet(post)
      end

      private

      def create_spreadsheet(post)
        book = Spreadsheet::Workbook.new
        sheet = book.create_worksheet
        sheet.row(0).concat %w[ID Title Content]
        sheet.row(1).concat [post.id, post.title, post.content]
        sheet.row(3).concat %w[Comments]
        sheet.row(4).concat %w[ID Post_ID Content Commentable_ID Commentable_Type]
        post.comments.each_with_index do |comment, index|
          sheet.row(index + 5).concat [comment.id, comment.post_id, comment.content, comment.commentable_id, comment.commentable_type]
        end

        file_path = Rails.root.join("tmp", "post#{post.id}.xls")
        book.write file_path
        file_path
      end
    end
  end
end
