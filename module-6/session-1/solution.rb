def register_user(params)
    new_user = User.new(params)
    new_user.role = "admin" # or new_user.set_as_admin

    # or new.user.set_password
    if new_user.empty_password?
        new_user.generate_password # new_user.gen_pass
    end

    raise Error::InvalidUserError if new_user.invalid?
    raise Error::DuplicateUser if new_user.is_duplicate?

    new_user.save
    new_user.send_email_confirmation    # a.sendmailcnfrm
    
    new_user
 end

 class User
    #...
    def empty_password?
        return @password.blank?
    end

    def set_password
       @password = generate_password if empty_password?
    end

    def invalid?
        @email.blank? 
        || @username.blank?
        || @phone.blank?
        || !(@email.match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i))
        || !(@phone.match(/\A\+?[\d\s\-\.\(\)]+\z/))
    end

    def is_duplicate?
        User.query("select count(1) from users where phone=#{@phone} or email=#{@email}") > 0
    end

    def set_as_admin
        @role = "admin"
    end
 end
