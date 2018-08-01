class Article < ApplicationRecord

  attr_accessor :top3_comments
  belongs_to :user
  has_many   :comments, as: :commentable

  def self.attach_recent_3_comments(articles)
    return articles if articles.blank?

    sql = send(:sanitize_sql_array, ["
      select * from (
        select ROW_NUMBER() over (partition by c.commentable_type, c.commentable_id order by c.id desc ) as row_number, c.*
        from comments c
        where c.commentable_type = ? and c.commentable_id in (?)
      ) ps where ps.row_number < 4 ;
                                     ", 'Article' , articles.map(&:id)])

    results = connection.select_all sql

    comments = results.rows.map{ |row| Comment.new(Hash[results.columns.zip(row)]) }

    articles_hash = Hash[articles.map{|article| [article.id, article]}]
    users_hash = {}
    users_hash = Hash[User.where(id: comments.map(&:user_id).uniq).map{|u| [u.id, u]}] unless comments.blank?

    comments.each do |cmt|
      article = articles_hash[cmt.commentable_id]
      cmt.user = users_hash[cmt.user_id]
      article.top3_comments ||= []
      article.top3_comments << cmt
    end

    articles
  end

end
