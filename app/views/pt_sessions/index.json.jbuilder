# frozen_string_literal: true

json.array! @pt_sessions, partial: 'pt_sessions/pt_session', as: :pt_session
