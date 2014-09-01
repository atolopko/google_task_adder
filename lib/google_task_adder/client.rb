module GoogleTaskAdder
  class Client

    USER_CONFIG_DIR = File.join(File.expand_path('~'), '.google_task_adder')
    CLIENT_SECRETS_FILE = File.join(USER_CONFIG_DIR, 'client_secrets.json')
    CREDENTIAL_STORE_FILE = File.join(USER_CONFIG_DIR, 'oauth2.json')

    def initialize
      @google_client = Google::APIClient.new(application_name: 'Google Task Adder',
                                             application_version: '0.1.0')
      @tasks = @google_client.discovered_api('tasks', 'v1')

      client_secrets = Google::APIClient::ClientSecrets.load(CLIENT_SECRETS_FILE)

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

    # Options: 
    # title: the title of the task
    # note: additional note text associated with the task
    # list: title of Task List into which new task will be inserted (defaults to first list)
    # For other accepted task attributes, see https://developers.google.com/google-apps/tasks/v1/reference/tasks#resource
    def add(opts = {})
      tasklist = find_list(opts.delete(:list)) { |lists| lists[0] }
      task = @tasks.tasks.insert.request_schema.new(opts)
      result = @google_client.execute(api_method: @tasks.tasks.insert,
                                      parameters: { tasklist: tasklist.id },
                                      body_object: task)
      result.body
    end
    
    def find_list(name)
      _lists = lists
      _lists.find { |l| l.title == name } or 
        yield _lists
    end
    
    def lists
      response = @google_client.execute(api_method: @tasks.tasklists.list)
      response.data.items
    end

  end
end
