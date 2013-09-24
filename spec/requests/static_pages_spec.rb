require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading)    { 'Ugaday chislo' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    #it { should_not have_selector 'title', text: '| Something' }

  end

  #it "should have the right links on the layout" do
    #click_link "Home"
    #page.should have_selector 'title', text: full_title('')
    #click_link "Sign up now!"
    #page.should have_selector 'title', text: full_title('Sign up')
  #end
end