#include <stdio.h>
#include <curl/curl.h>

// Callback function to handle API response
size_t write_callback(void *ptr, size_t size, size_t nmemb, char *data) {
    // This example just prints the response to the console
    printf("%s\n", data);
    return size * nmemb;
}

int main(void) {
    CURL *curl;
    CURLcode res;
    
    // Initialize curl
    curl = curl_easy_init();
    if(curl) {
        // Set the API endpoint
        curl_easy_setopt(curl, CURLOPT_URL, "https://api.openai.com/v1/engines/text-davinci-003/completions");
        
        // Set headers
        struct curl_slist *headers = NULL;
        headers = curl_slist_append(headers, "Content-Type: application/json");
        headers = curl_slist_append(headers, "Authorization: Bearer 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"); // Replace YOUR_API_KEY with your actual API key
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
        
        // Set the input prompt
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, "{\"prompt\": \"Hello, ChatGPT!\"}");
        
        // Set callback function to handle response
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
        
        // Perform the request
        res = curl_easy_perform(curl);
        
        // Cleanup
        curl_easy_cleanup(curl);
        curl_slist_free_all(headers);
    }
    
    return 0;
}
