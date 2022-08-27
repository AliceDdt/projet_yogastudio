// app/javascript/application.js

import Rails from '@rails/ujs';
Rails.start();

import 'cart';
// The two following lines disable Turbo on the whole application
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false