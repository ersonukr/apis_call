module Api
  module V1
    class MembersController < JSONAPI::ResourceController
      def create
        errors = Array.new
        error = check_params(params)
        if error.nil?
          auth_key = params[:auth_key]
          profiles = params[:data]
          bpo_vender = authenticate(auth_key)
          if bpo_vender.is_a?(BpoVender)
            #loop through all profiles
            profiles.each do |data|
              phone = Phone.find(data[:phone_id]) rescue nil
              if phone.present?
                member = Member.unscoped.joins(:phones).where('phones.id = ?',phone.id).first
                if member.present?
                  member.name = data[:name]
                  member.english_profiency = data[:english_profiency] if data[:english_profiency].present?
                else
                  if data[:english_profiency].present?
                    member = Member.new({:name => data[:name], :english_profiency => data[:english_profiency], :active => false})
                  else
                    member = Member.new({:name => data[:name], :active => false})
                  end
                end
                #if member save successfully
                if member.save
              
                  #initialize arrays
                  relations = Array.new
                  categories = Array.new
                  employer_types = Array.new
                  areas = Array.new
                  educations = Array.new
                  experiences = Array.new
                  
                  #check category
                  if data[:category_id].present?                    
                    #testing integer or string
                    if data[:category_id] =~ /^\d+$/
                      categories = Category.where({:id => data[:category_id]}) rescue nil
                      if member.freetexts.where({:type_of => Freetext::TypeOf[:category]}).exists?
                        member.freetexts.where({:type_of => Freetext::TypeOf[:category]}).delete_all
                      end
                    else
                      freetext = Freetext.find_by({:type_of => Freetext::TypeOf[:category], :text => data[:category_id]}) rescue nil
                      if freetext.present?
                        freetext.members << member if Member.unscoped.joins(:freetexts).where("freetexts.id = ? and members.id = ?",freetext.id,member.id).blank?
                      else
                        freetext = Freetext.create({:type_of => Freetext::TypeOf[:category], :text => data[:category_id]}) rescue nil
                        if freetext.nil?
                          message = "[api][v1][members controller][create] - (Member - #{member.inspect} , Text - #{data[:category_id]})"
                          UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
                        else
                          freetext.members << member if Member.unscoped.joins(:freetexts).where("freetexts.id = ? and members.id = ?",freetext.id,member.id).blank?
                        end
                      end
                    end
                  else
                    errors << "phone id (#{data[:phone_id]}) - category id is nil"
                  end
                  #check employer type
                  if data[:emp_type_id].present?
                    if data[:emp_type_id] =~ /^\d+$/
                      employer_types = EmpType.where({:id => data[:emp_type_id]}) rescue nil
                      if member.freetexts.where({:type_of => Freetext::TypeOf[:emp_type]}).exists?
                        member.freetexts.where({:type_of => Freetext::TypeOf[:emp_type]}).delete_all
                      end
                    else
                      freetext = Freetext.find_by({:type_of => Freetext::TypeOf[:emp_type], :text => data[:emp_type_id]}) rescue nil
                      if freetext.present?
                        freetext.members << member if Member.unscoped.joins(:freetexts).where("freetexts.id = ? and members.id = ?",freetext.id,member.id).blank?
                      else
                        freetext = Freetext.create({:type_of => Freetext::TypeOf[:emp_type], :text => data[:emp_type_id]}) rescue nil
                        if freetext.nil?
                          message = "[api][v1][members controller][create] - (Member - #{member.inspect} , Text - #{data[:emp_type_id]})"
                          UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
                        else
                          freetext.members << member if Member.unscoped.joins(:freetexts).where("freetexts.id = ? and members.id = ?",freetext.id,member.id).blank?
                        end
                      end
                    end
                  else
                    errors << "phone id (#{data[:phone_id]}) - emp type id is nil"
                  end
                  #check location
                  if data[:location_area_id].present?
                    if data[:location_area_id] =~ /^\d+$/
                      if data[:location_type] == Address::Location_type[:location]
                        location = Location.find(data[:location_area_id]) rescue nil
                        if location.present?
                          areas << location.area
                        end
                      end
                      if data[:location_type] == Address::Location_type[:area]
                        areas = Area.where({:id => data[:location_area_id]}) rescue nil
                      end
                      if member.freetexts.where({:type_of => Freetext::TypeOf[:location]}).exists?
                        member.freetexts.where({:type_of => Freetext::TypeOf[:location]}).delete_all
                      end
                    else
                      freetext = Freetext.find_by({:type_of => Freetext::TypeOf[:location], :text => data[:location_area_id]}) rescue nil
                      if freetext.present?
                        freetext.members << member if Member.unscoped.joins(:freetexts).where("freetexts.id = ? and members.id = ?",freetext.id,member.id).blank?
                      else
                        freetext = Freetext.create({:type_of => Freetext::TypeOf[:location], :text => data[:location_area_id]}) rescue nil
                        if freetext.nil?
                          message = "[api][v1][members controller][create] - (Member - #{member.inspect} , Text - #{data[:location_area_id]})"
                          UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
                        else
                          freetext.members << member if Member.unscoped.joins(:freetexts).where("freetexts.id = ? and members.id = ?",freetext.id,member.id).blank?
                        end
                      end
                    end
                  else
                    errors << "phone id (#{data[:phone_id]}) - location id is nil"
                  end
                  #check education
                  if data[:education_id].present?
                    if data[:education_id] =~ /^\d+$/
                      educations = Education.where({:id => data[:education_id]}) rescue nil
                      if member.freetexts.where({:type_of => Freetext::TypeOf[:education]}).exists?
                        member.freetexts.where({:type_of => Freetext::TypeOf[:education]}).delete_all
                      end
                    else
                      freetext = Freetext.find_by({:type_of => Freetext::TypeOf[:education], :text => data[:education_id]}) rescue nil
                      if freetext.present?
                        freetext.members << member if Member.unscoped.joins(:freetexts).where("freetexts.id = ? and members.id = ?",freetext.id,member.id).blank?
                      else
                        freetext = Freetext.create({:type_of => Freetext::TypeOf[:education], :text => data[:education_id]}) rescue nil
                        if freetext.nil?
                          message = "[api][v1][members controller][create] - (Member - #{member.inspect} , Text - #{data[:education_id]})"
                          UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
                        else
                          freetext.members << member if Member.unscoped.joins(:freetexts).where("freetexts.id = ? and members.id = ?",freetext.id,member.id).blank?
                        end
                      end
                    end
                  end
                  #check experience years
                  if data[:experience_years].present?
                    if data[:experience_years] =~ /^\d+$/
                      if data[:experience_years] =~ /^\d{1,2}$/
                        years = data[:experience_years]
                      end
                    end
                  end
                  #check experience months
                  if data[:experience_months].present?
                    if data[:experience_months] =~ /^\d+$/
                      if data[:experience_months] =~ /^\d{1,2}$/
                        months = data[:experience_months]
                      end
                    end
                  end
                  #create experience
                  if years.present? and months.present?
                    total_months = years.to_i*12 + months.to_i
                  end
                  if years.present? and months.nil?
                    total_months = years.to_i*12
                  end
                  if months.present? and years.nil?
                    total_months = months.to_i
                  end
                  #destroy extra experiences
                  experiences = member.experiences
                  total_experiences = experiences.length
                  if total_experiences > 1
                    experiences = experiences[1..(total_experiences-1)]
                    experiences.map{|exp| exp.destroy}
                  end
                  #create experiences
                  if total_months.present?
                    experience = member.experiences.first
                    if experience.present?
                      experience.update({:member => member, :years => total_months, :job_id =>nil})
                    else
                      experience = Experience.create({:member => member, :years=>total_months, :job_id =>nil})
                      if experience.nil?
                        message = "[api][v1][members controller][create] - unable to create experience with #{member.inspect} and #{total_months}"
                        UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
                      end
                    end
                  end
                  
                  #destroy extra relations
                  relations = phone.relations
                  total_relations = relations.length
                  if total_relations > 1
                    relations = relations[1..(total_relations-1)]
                    relations.map{|r| r.destroy}
                  end
                  #create relations
                  relation = phone.relations.first
                  if relation.present?
                    relation.update({:member => member, :relation_type => Relation::Relationship[:self]}) rescue nil
                  else
                    relation = Relation.create({:member => member, :phone => phone, :relation_type => Relation::Relationship[:self]}) rescue nil
                    if relation.nil?
                      message = "[api][v1][members controller][create] - unable to create relation with #{member.inspect} and #{phone.inspect}"
                      UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
                    end
                  end
                  
                  #assigning associations
                  if categories.present?
                    member.categories = categories
                  end
                  if employer_types.present?
                    member.emp_types = employer_types
                  end
                  if areas.present?
                    member.areas = areas
                  end
                  if educations.present?
                    member.educations = educations
                  end
                else
                  message = "[api][v1][members controller][create] - unable to create member with #{data[:name]} and #{data[:english_profiency]}"
                  UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
                end
              else
                errors << "phone id (#{data[:phone_id]}) - invalid phone id"
              end
            end
            if errors.blank?
              @response = {:status => "success", :message => "#{profiles.length} profiles created successfully", :errors => nil}
            else
              @response = {:status => "failure", :message => (errors.length > 1 ? "#{errors.length} errors" : "#{errors.length} error"), :errors => errors.join(',')}
            end
          else
            @response = {:status => "failure", :message => "1 error", :errors => "invalid auth key"}
          end
        else
          @response = error
        end
        render :json => @response
      end
      
      private
      def authenticate(auth_key)
        BpoVender.find_by_auth_key(auth_key) rescue nil
      end
      def check_params(params)
        if params[:data].nil?
          message = "[api][v1][members controller][check params] - data key not found"
          UnnatiMailer.delay(run_at: 10.seconds.from_now, queue: 'email').system_notification(message,"Admin")
          return {:status => "failure", :message => "1 error", :errors => "data key not found"}
        end
      end
    end
  end
end