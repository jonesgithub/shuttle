# encoding: utf-8

# Copyright 2013 Square Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

module Views
  module Devise
    module Mailer
      class ConfirmationInstructions < Erector::Widget
        needs :resource

        def content
          div do
            p "Welcome #{@resource.email}!"
            p "You can confirm your account email through the link below:"
            p { link_to 'Confirm my account', confirmation_url(@resource, confirmation_token: @token) }
          end
        end
      end
    end
  end
end
