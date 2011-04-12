require 'test_helper'

describe "Achievable" do
  
  before do
    @achieve1 = Achievement.create!(:name => "achievement1", :description => "test achievement 1", :category => "achi")
    @achieve2 = Achievement.create!(:name => "achievement2", :description => "test achievement 2", :category => "achi")
    @achieve3 = Achievement.create!(:name => "achievement3", :description => "test achievement 3", :category => "achi")
    @user1    = User.create!(:name => "he9qi",  :image_url => "1.png")
    @user2    = User.create!(:name => "he9lin", :image_url => "2.png")
    @post1    = Post.create!(:name => "post1", :user => @user1)
    @post2    = Post.create!(:name => "post2", :user => @user2)
    Achievable.set_resque_enable(false)
  end
  
  after do
    Achievement.destroy_all
    Achieving.destroy_all
    User.destroy_all
    Post.destroy_all
  end
  
  it "should return true if user has the achievemnt it is asking for" do
    @achieve1.achieve(@user1)
    @user1.achieved?("achievement1").should be_true
  end
  
  context "When user update image_url" do
    before do
      User.class_eval do
        achievable :image_url,  "achievement1"
      end
    end
    
    it "should give user an achievement" do
      with_resque do
        @user1.image_url = "2.png"
        @user1.save!
      end
      @user1.achieved?("achievement1").should be_true
    end
    
  end
  
  context "Conditional achievement" do
    context "When user update posts and the user is not he9qi" do
      before do
        Post.class_eval do
          achievable :name,  "achievement2", :receiver => :user, :condition => lambda { |u| u.name = "he9qi" }
        end
      end
    
      it "should not give user an achievement" do
        with_resque do 
          @post2.name = "post3"
          @post2.save!
        end
        @user1.achieved?("achievement2").should be_false
      end
    end
    
    context "When user update posts and the user is he9qi" do
      before do
        Post.class_eval do
          achievable :name,  "achievement2", :receiver => :user, :condition => lambda { |u| u.name = "he9qi" }
        end 
      end
    
      it "should give user an achievement" do
        with_resque do 
          @post1.name = "post2"
          @post1.save!
        end
        @user1.achieved?("achievement2").should be_true
      end
    end
  end
  
  context "Resque Enable: When user update posts and the user is he9qi" do
    before do
      Achievable.set_resque_enable(true)
      Post.class_eval do
        achievable :name,  "achievement2", :receiver => :user, :condition => lambda { |u| u.name = "he9qi" }
      end
    end
  
    it "should not give user an achievement if resque not started" do
      @post1.name = "post2"
      @post1.save!
      @user1.achieved?("achievement2").should be_false
    end
    
    it "should give user an achievement" do
      with_resque do 
        @post1.name = "post2"
        @post1.save!
      end
      @user1.achieved?("achievement2").should be_true
    end
    
  end

end
