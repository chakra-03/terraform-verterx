resource "google_vertex_ai_prompt" "messi_ronaldo_prompt" {
  project = "beta-ruler"
  display_name = "Messi Ronaldo Prompt"  # Name that will appear in the Prompt Management UI
  description  = "Asks who is better, Messi or Ronaldo." # Optional description

  model_name = "gemini-1.0-pro"  # Choose the model to associate with this prompt

  input_text = "who is better messi or ronaldo?"
  # examples {
  #   input {
  #     text = "Give a balanced argument."
  #   }
  #   output {
  #     text = "Lionel Messi and Cristiano Ronaldo are both exceptionally talented footballers, widely considered among the greatest of all time.  Messi's strengths lie in his dribbling, close control, and playmaking abilities. He is known for his goal-scoring prowess and has won numerous Ballon d'Or awards.  Ronaldo excels in his athleticism, aerial ability, and powerful striking. He is a prolific goalscorer with a strong work ethic.  Ultimately, determining who is 'better' is subjective and depends on individual preferences and criteria."
  #   }
  # }
  # Optional parameters
  open_ai_prompt {
        context = "The user is looking for a balanced and objective opinion."
        # examples = [] # add examples here if desired.  These help with the prompt's performance
        suffix = "Please provide more background information on the user's point of view"
    }

  # Optional: To set access control, use google_project_iam_member or similar resources
  # to grant necessary roles to your service account.
  # depends_on = [google_project_iam_member.your_service_account_access] # If you use this, configure google_project_iam_member

}

# Example IAM binding (adjust to your needs): You need to give the necessary permissions to your service account
# to allow it to deploy the model. Replace "your-service-account@your-project.iam.gserviceaccount.com"
# with the actual service account you're using.  This is usually done on the project level.
# resource "google_project_iam_member" "your_service_account_access" {
#   project = "beta-ruler"
#   role    = "roles/aiplatform.modelDeploymentUser" # Required to use Vertex AI resources
#   member  = "serviceAccount:your-service-account@your-project.iam.gserviceaccount.com"
# }


output "prompt_id" {
  value = google_vertex_ai_prompt.messi_ronaldo_prompt.id
}

output "prompt_name" {
  value = google_vertex_ai_prompt.messi_ronaldo_prompt.display_name
}
