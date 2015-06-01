require 'active_support'
require 'fileutils'
require 'msgpack'
require './lib/warrior'
require './data/trials'

curmsg = nil

puts "Welcome, oh mighty Pushup Warrior!"

#todo: check for task version => 2.2

puts "Enter name:"
username = gets.chomp
p 		 = PushupWarrior.new(username)
pp 		 = p.class.load_profile(username)
p.gender = pp["gender"]
p.age    = pp["age"]
p.week   = pp["week"]
p.day    = pp["day"]

if p.week == 0 && p.day == 0
	###[weekNum,dayNum,inprogress]
	curmsg = [0,0,0]
	require_relative './work/trial_run'
	puts "Alright, you soldier of pushups! How many did you do?"
	fpcount = gets
	curmsg <<(1) #saying how many pushups appends a 1 signaling that it's complete.
	curmsg = curmsg.to_msgpack
	open("app/warriors/#{username}/init", 'w') { |f|
		f.puts MessagePack.unpack(curmsg)
	}
	t = PushupTrials.new(p.gender,p.age,fpcount)
	first_week = "#{t}".to_i
	open("app/warriors/#{username}/1", 'w') { |f|
		f.puts "#{first_week}"
	}
	p.week == 1 && p.day == 1
	curmsg = [1,1,0].to_msgpack
end