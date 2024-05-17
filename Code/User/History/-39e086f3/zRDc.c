void phase_1(char* input) {
    int len_input = strlen(input);
    int len_target = strlen("We crack codes with finesse."); // Replace with the actual target string

    // The following lines perform a complex calculation to get the same value as len_target.
    // This is likely done to obfuscate the code and make reverse engineering more difficult.
    long long calc = len_target;
    calc = ((calc * 5) << 4) + calc;
    calc = ((calc << 8) + calc) << 16;
    calc += calc >> 32;
    calc -= calc >> 31;

    if (len_input != calc) {
        explode_bomb();
    }
}

void main(){
    char inptut_str[] = "We crack codes with finesse.";

}