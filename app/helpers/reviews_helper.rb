module ReviewsHelper
  def ave_star(review)
    review_star_ary = [
      review.curriculum_star, review.support_star,
      review.teacher_star, review.compatibility_star,
    ]
    new_review_star_ary = review_star_ary.compact
    if new_review_star_ary.size != 0
      sum_star = 0
      new_review_star_ary.each do |star|
        sum_star += star
      end
      ave_star = sum_star / new_review_star_ary.size
      ((ave_star * 2.0).round / 2.0).to_f
    end
  end

  def all_reviews_ave_star(school)
    if school.reviews.size != 0
      all_reviews_sum = 0
      i = 0
      school.reviews.each do |review|
        unless review.average_star.nil?
          i += 1
          all_reviews_sum += review.average_star
        end
      end
      all_reviews_ave = all_reviews_sum / i
      ((all_reviews_ave * 2.0).round / 2.0).to_f
    end
  end
end
