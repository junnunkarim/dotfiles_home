#include <security/pam_appl.h>
#include <security/pam_misc.h>

static int pam_conv(int num_msg, const struct pam_message **msg, struct pam_response **resp, void *appdata_ptr);
struct pam_conv pamc = {pam_conv, NULL};