require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    web_page = Nokogiri::HTML(open(index_url))
        list = []
        students = {}
        web_page.css("div.student-card").each do |student|
          students = {
            :name => student.css(".student-name").text,
            :location => student.css(".student-location").text,
            :profile_url => student.css("a").attribute('href').value
          }
          list << students
        end
        list
        # binding.pry


  end

  def self.scrape_profile_page(profile_url)
    web_page = Nokogiri::HTML(open(profile_url))

    scraped_student = {}
    web_page.css(".social-icon-container").each do |link|
      scraped_student = {
        :twitter => link.css("a")[0].attribute("href").value,
        :linkedin => link.css("a")[1].attribute("href").value,
        :github => link.css("a")[2].attribute("href").value,
        :blog => link.css("a")[3].attribute("href").value
      }
    end
    scraped_student[:profile_quote] = web_page.css(".main-wrapper.profile .vitals-text-container .profile-quote").text
    scraped_student[:bio] = web_page.css(".main-wrapper.profile .description-holder p").text

    scraped_student
    # binding.pry

  end


end
#  if link.include?("twitter")
#   scraped_student[:twitter] = link.css("a")[0].attribute("href").value
# elsif link.include?("linkedin")
#   scraped_student[:linkedin] = link.css("a")[1].attribute("href").value
# elsif link.include?("github")
#   scraped_student[:github] = link.css("a")[2].attribute("href").value
# else link.include?("blog")
#   scraped_student[:blog] = link.css("a")[3].attribute("href").value
# end
