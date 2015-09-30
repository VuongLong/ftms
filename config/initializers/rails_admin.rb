require Rails.root.join("lib", "rails_admin", "show_subject.rb")
require Rails.root.join("lib", "rails_admin", "start_course.rb")
require Rails.root.join("lib", "rails_admin", "finish_course.rb")
require Rails.root.join("lib", "rails_admin", "show_course.rb")
require Rails.root.join("lib", "rails_admin", "start_course_subject.rb")
require Rails.root.join("lib", "rails_admin", "finish_course_subject.rb")
require Rails.root.join("lib", "rails_admin", "add_trainee_to_course.rb")
require Rails.root.join("lib", "rails_admin", "add_subjects_to_course.rb")
require Rails.root.join("lib", "rails_admin", "delete.rb")
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::ShowSubject)
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::StartCourse)
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::FinishCourse)
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::ShowCourse)
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::StartCourseSubject)
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::FinishCourseSubject)
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::AddTraineeToCourse)
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::AddSubjectsToCourse)
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::Delete)

RailsAdmin.config do |config|

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with :cancan

  config.actions do
    dashboard
    index
    new do
      except "Task"
    end
    bulk_delete
    show_subject
    show_course do
      only Course
    end
    show do
      except ["Subject", "Course"]
    end
    edit do
      except "Task"
    end
    delete
    finish_course_subject do
      only [Course, CourseSubject]
    end
    start_course_subject do
      only [Course, CourseSubject]
    end
    start_course do
      only Course
    end
    finish_course do
      only Course
    end
    add_trainee_to_course do
      only Course
    end
    add_subjects_to_course do
      only Course
    end
    show_in_app do
      hide
    end
  end
end
