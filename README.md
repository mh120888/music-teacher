music-teacher
=============

Dashboard for music teachers to manage payments, track appointments, and manage music assets

adding a secret token
==========================

goto config/initializers/secret_token.rb

add this to the file:

MusicTeacherRails::Application.config.secret_token = #result#

what you replace with #result# is the output of
rake secret
