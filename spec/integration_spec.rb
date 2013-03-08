require "spec_helper"

feature "Using jsrender", js: true do
  after do
    Rails.application.config.jsrender.prefix = ''
  end

  scenario "Loading a page that uses jsrender" do
    visit "/"
    page.should have_content("Sebastian Pape")
  end

  scenario "Using template prefix", js: true do
    Rails.application.config.jsrender.prefix = 'views'
    visit "/prefix"
    page.should have_content("Sebastian Pape")
  end

  scenario "Using a regular expression as a template prefix", js: true do
    Rails.application.config.jsrender.prefix = %r{([^/]*/)*}
    visit "/prefix"
    page.should have_content("Sebastian Pape")
  end
end
