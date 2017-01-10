require 'rails_helper'
require 'spec_helper'

describe "root page", :type => :feature do

  it "opens root page" do
    visit '/'
    expect(page).to have_content 'Routine Tracker MAKE EVERY POUND COUNT! Join free to create workout routines, record your results, and see your progress.'
  end
end