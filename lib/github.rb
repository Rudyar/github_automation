require 'watir'
require 'dotenv'

Dotenv.load('/home/rud/Documents/code/github_automation/.env') #Long path due to the alias for my terminal use
PASSWORD = ENV["PASSWORD"] # Put your Github password in the .env file

# Method to collect the new dir_name
def collect_dir_name

  dir_name = ARGV
  abort ("Rentre un nom de repo mec !") if ARGV.empty?
  return dir_name[0]
end


# Login on github
def login_github(browser)
  
  browser.goto 'https://github.com/login'
  login = browser.text_field(id: 'login_field')
  login.set("Rudyar")
  pass = browser.text_field(id: 'password')
  pass.set(PASSWORD)
  pass.send_keys(:enter)
end

# Create the new repo Github

def new_repo_github(browser, repo_name)
  
  newbtn = browser.a(class: "btn btn-sm btn-primary text-white")
  newbtn.click

  new_repo_name = browser.text_field(id: 'repository_name')
  new_repo_name.set(repo_name) # Set the name of the new repo (same as the dir_name)

  browser.scroll.to (:bottom) # due to the cookies popup sometimes

  creat_new_repo_btn = browser.button(visible_text: "Create repository")
  creat_new_repo_btn.click
  browser.close
  puts "-- New repo Github created --"
end

# Perform to launch the script
def perform
  dir_name = collect_dir_name

  browser = Watir::Browser.new(:firefox)
  login_github(browser)
  new_repo_github(browser, dir_name)
  puts "Voici ton git remote :"
  puts "----------------------"
  puts "git remote add origin https://github.com/Rudyar/#{dir_name}.git"
end

perform

