require_relative 'user_roles'

module Authorizable
  def initialize(*args, &block)
    super
    self.role ||= UserRoles.initial_role
  end

  def self.define_role_methods(role_names)
    role_names.each do |role_name|
      define_method("make_#{role_name}") do
        update_attributes role: role_name
      end

      define_method("#{role_name}?") do
        role == role_name
      end
    end
  end

  define_role_methods(UserRoles.all)
end
