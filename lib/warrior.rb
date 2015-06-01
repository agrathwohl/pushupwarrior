require 'active_support'
require 'fileutils'

class PushupWarrior
	attr_accessor :username, :gender, :age, :week, :day
	def initialize(username=nil,gender=nil,age=nil,week=nil,day=nil)
		self.username = username
		new_user      = true
		puts "Hello, #{@username}!"
		warriors_dir  = Dir.glob 'app/warriors/*/'
		warriors_dir.each do |warrior_dir|
			if @username == "#{warrior_dir.split('/').last}"
				puts "Profile match found."
				new_user = false
				self.class.load_profile(username)
			end
		end
		self.class.new_profile(username) if new_user == true
	end

	def self.new_profile(username)
		puts "What is your gender? [M/F]:"
		@gender 			 = gets.chomp
		puts "What is your age?:"
		@age    			 = gets.chomp
		puts "\nLet's recap:"
		puts "\nName:#{username}\nGender:#{@gender}\nAge:#{@age.to_i}\n"
		puts "Press any key to save your profile to disk and continue..."
		gets
		FileUtils::mkdir_p "app/warriors/#{username}"
		open("app/warriors/#{username}/profile", 'w') { |f|
			f.puts "#{username}"
			f.puts "#{@gender}"
			f.puts "#{@age}"
			f.puts "0" #todo: if user tests well on first trial, make week = 3
			f.puts "0"
		}
		self.load_profile(username)
	end

	def self.load_profile(username)
		user_profile = File.open("app/warriors/#{username}/profile").read.split("\n")
		return {
      		"username" => "#{user_profile[0]}",
      		"gender"   => "#{user_profile[1]}",
      		"age" 	   => "#{user_profile[2]}".to_i,
      		"week"     => "#{user_profile[3]}".to_i,
      		"day"      => "#{user_profile[4]}".to_i
      	}
	end	
end
