// #include <stdio.h>
// #include <curl/curl.h>

// // Callback function to handle API response
// size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp)
// {
//     size_t totalSize = size * nmemb;
//     printf("%.*s", (int)totalSize, (char*)contents);
//     return totalSize;
// }

// int main(void) {
//     CURL *curl;
//     CURLcode res;
    
//     // Initialize curl
//     curl = curl_easy_init();
//     if(curl) {
//         // Set the API endpoint
//         curl_easy_setopt(curl, CURLOPT_URL, "https://api.openai.com/v1/chat/completions");
        
//         // Set headers
//         struct curl_slist *headers = NULL;
//         headers = curl_slist_append(headers, "Content-Type: application/json");
//         headers = curl_slist_append(headers, "Authorization: Bearer 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"); 
//         curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        
//         // Set the input prompt
//         curl_easy_setopt(curl, CURLOPT_POSTFIELDS, "{\"prompt\": \"Hello, ChatGPT!\"}");
        
//         // Set callback function to handle response
//         curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
        
//         // Perform the request
//         res = curl_easy_perform(curl);
        
//         // Cleanup
//         curl_easy_cleanup(curl);
//         curl_slist_free_all(headers);
//     }
    
//     return 0;
// }





#include <stdio.h>
#include <curl/curl.h>

size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp)
{
    size_t totalSize = size * nmemb;
    printf("%.*s", (int)totalSize, (char*)contents);
    return totalSize;
}

int main(void)
{
  CURL *curl;
  CURLcode res;

  curl_global_init(CURL_GLOBAL_DEFAULT);

  curl = curl_easy_init();
  if(curl) {
    struct curl_slist *headers = NULL;

    headers = curl_slist_append(headers, "Content-Type: application/json");
    headers = curl_slist_append(headers, "Authorization: Bearer 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");

    curl_easy_setopt(curl, CURLOPT_URL, "https://api.openai.com/v1/chat/completions");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);

    // Set the data for the POST.
    curl_easy_setopt(curl, CURLOPT_POSTFIELDS, "{\
        \"model\":\"gpt-3.5-turbo\",\
        \"prompt\":\"Hello, ChatGPT!\"}");
    // \"messages\":[\
        //     {\"role\":\"user\",\
        //     \"content\":\"Say this is a test!\"}],\"temperature\":0.7}");

    // Set the write callback
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);

    // Perform the request, res will get the return code
    res = curl_easy_perform(curl);

    // Check for errors
    if(res != CURLE_OK)
      fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));

    // Always cleanup
    curl_easy_cleanup(curl);
  }

  curl_global_cleanup();

  return 0;
}