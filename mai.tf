resource "google_vertex_ai_generative_model" "prompt_model" {
  project = "beta-ruler"
  name   = "messi-ronaldo-prompt"  # Choose a descriptive name for your model

  model = "gemini-1.0-pro"  # Or any other generative model you prefer
  # description = "A prompt model asking who is better, Messi or Ronaldo." # Optional description

  generation_config {
    temperature = 0.2 # Lower temperature for more deterministic responses
    top_p       = 0.95 # Use a moderate top-p for sampling
    top_k       = 40   # A reasonable top-k value
    max_output_tokens = 256 # Limit the output length to avoid excessively long answers
  }

  safety_settings {
    category  = "HARM_CATEGORY_HATE_SPEECH"
    threshold = "BLOCK_LOW_AND_ABOVE"
  }

  safety_settings {
    category  = "HARM_CATEGORY_SEXUALLY_EXPLICIT"
    threshold = "BLOCK_LOW_AND_ABOVE"
  }

  safety_settings {
    category  = "HARM_CATEGORY_DANGEROUS_CONTENT"
    threshold = "BLOCK_LOW_AND_ABOVE"
  }

  safety_settings {
    category  = "HARM_CATEGORY_HARASSMENT"
    threshold = "BLOCK_LOW_AND_ABOVE"
  }

  content {
      parts {
          text = "who is better messi or ronaldo?"
      }
      role = "user"
  }

  content {
      parts {
          text = "As a large language model, I am unable to make a value judgement as this question is a subjective matter of opinion. It depends on who you ask, and what metrics are used to compare both players."
      }
      role = "model"
  }

  # Optional: To set access control, use google_project_iam_member or similar resources
  # to grant necessary roles to your service account.
  # Example:
  # depends_on = [google_project_iam_member.your_service_account_access] # If you use this, configure google_project_iam_member
}

#  Example IAM binding (adjust to your needs): You need to give the necessary permissions to your service account
# to allow it to deploy the model. Replace "your-service-account@your-project.iam.gserviceaccount.com"
# with the actual service account you're using.  This is usually done on the project level.
# resource "google_project_iam_member" "your_service_account_access" {
#   project = "beta-ruler"
#   role    = "roles/aiplatform.modelDeploymentUser" # Required to deploy Vertex AI models
#   member  = "serviceAccount:your-service-account@your-project.iam.gserviceaccount.com"
# }

output "prompt_model_id" {
  value = google_vertex_ai_generative_model.prompt_model.id
}

output "prompt_model_name" {
  value = google_vertex_ai_generative_model.prompt_model.name
}
