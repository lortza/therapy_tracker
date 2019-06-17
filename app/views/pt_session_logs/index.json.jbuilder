# frozen_string_literal: true

json.array! @pt_session_logs, partial: 'pt_session_logs/pt_session', as: :pt_session
