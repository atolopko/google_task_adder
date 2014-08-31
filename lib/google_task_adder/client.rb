module GoogleTaskAdder
  class Client

    CREDENTIAL_STORE_FILE = "google-task-adder-oauth2.json"

    def initialize
      @google_client = Google::APIClient.new(application_name: 'Google Task Adder',
                                             application_version: '0.1.0')
      @tasks = @google_client.discovered_api('tasks', 'v1')

      client_secrets = Google::APIClient::ClientSecrets.load

      # FileStorage stores auth credentials in a file, so they survive multiple runs
      # of the application. This avoids prompting the user for authorization every
      # time the access token expires, by remembering the refresh token.
      # Note: FileStorage is not suitable for multi-user applications.
      file_storage = Google::APIClient::FileStorage.new(CREDENTIAL_STORE_FILE)
      if file_storage.authorization.nil?
        flow = Google::APIClient::InstalledAppFlow.new(client_id: client_secrets.client_id,
                                                       client_secret: client_secrets.client_secret,
                                                       # read/write access flow
                                                       scope: ['https://www.googleapis.com/auth/tasks'])
        @google_client.authorization = flow.authorize(file_storage)
      else
        @google_client.authorization = file_storage.authorization
      end
    end

    def add(task)
    end

    def lists
      result = @google_client.execute(api_method: @tasks.tasklists.list)
      puts((JSON.load result.response.body)['items'].map { |l| l['title'] })
    end

  end
end
