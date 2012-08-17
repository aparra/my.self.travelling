get "/" do
  erb :index
end

get "/auth/twitter/callback" do
  auth = request.env["omniauth.auth"]

  Twitter.configure do |config|
    config.oauth_token = auth.credentials.token
    config.oauth_token_secret = auth.credentials.secret
  end

  begin
    redirect "/done"
  rescue Exception => error
    $stderr << "#{error.class} => #{error.message}\n"
    $stderr << error.backtrace.join("\n") << "\n"
    redirect "/fail"
  end
end

get "/auth/failure" do
  redirect "/fail"
end

get "/done" do
  erb :done
end

get "/fail" do
  erb :fail
end