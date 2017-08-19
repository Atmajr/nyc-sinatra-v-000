class Figure < ActiveRecord::Base
  has_many :landmarks
  has_many :figure_titles
  has_many :titles, :through => :figure_titles

  def slug
    slug = name.downcase.gsub(" ","-")
    slug = slug.gsub(/[^0-9A-Za-z\-]/, '')
  end

  def self.find_by_slug(slug)
    Figure.all.find{|figure| figure.slug == slug}
  end
end
