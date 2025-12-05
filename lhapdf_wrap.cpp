/**
 * C++ wrapper for LHAPDF6 to be called from Fortran
 * This provides the interface between Fortran and C++ LHAPDF6 library
 */

#include <iostream>
#include <string>
#include <cmath>

#ifdef USE_LHAPDF
#include "LHAPDF/LHAPDF.h"

static LHAPDF::PDF* current_pdf = nullptr;
static std::string current_pdfname = "";

extern "C" {

/**
 * Initialize LHAPDF PDF set
 */
void lhapdf_initpdf_(const char* pdfname, int len) {
    std::string name(pdfname, len);
    // Remove trailing spaces
    name.erase(name.find_last_not_of(' ') + 1);
    
    if (current_pdf && current_pdfname == name) {
        return; // Already initialized
    }
    
    if (current_pdf) {
        delete current_pdf;
    }
    
    current_pdfname = name;
    std::cout << "Initializing LHAPDF with PDF set: " << name << std::endl;
    current_pdf = LHAPDF::mkPDF(name, 0);
}

/**
 * Get PDFs for all flavors at given x and Q
 * This is called by the Fortran STRUCTM wrapper
 */
void lhapdf_getpdfs_(double* x, double* q, double* upv, double* dnv,
                     double* usea, double* dsea, double* str, double* chm,
                     double* bot, double* top, double* gl) {
    if (!current_pdf) {
        // Initialize with default PDF if not already initialized
        std::string default_pdf = "cteq6l1";
        std::cout << "Warning: LHAPDF not initialized, using default: " 
                  << default_pdf << std::endl;
        current_pdf = LHAPDF::mkPDF(default_pdf, 0);
        current_pdfname = default_pdf;
    }
    
    double q2 = (*q) * (*q);
    
    // Get x*f(x) from LHAPDF for all flavors
    // PDG codes: -6=tbar, -5=bbar, -4=cbar, -3=sbar, -2=dbar, -1=ubar,
    //            0=gluon, 1=d, 2=u, 3=s, 4=c, 5=b, 6=t
    double xfx_up = current_pdf->xfxQ2(2, *x, q2);
    double xfx_dn = current_pdf->xfxQ2(1, *x, q2);
    double xfx_ubar = current_pdf->xfxQ2(-2, *x, q2);
    double xfx_dbar = current_pdf->xfxQ2(-1, *x, q2);
    double xfx_s = current_pdf->xfxQ2(3, *x, q2);
    double xfx_c = current_pdf->xfxQ2(4, *x, q2);
    double xfx_b = current_pdf->xfxQ2(5, *x, q2);
    double xfx_t = current_pdf->xfxQ2(6, *x, q2);
    double xfx_glu = current_pdf->xfxQ2(0, *x, q2);
    
    // Convert x*f(x) to f(x) by dividing by x
    // Calculate valence and sea separately
    if (*x > 0.0) {
        *upv = (xfx_up - xfx_ubar) / (*x);
        *dnv = (xfx_dn - xfx_dbar) / (*x);
        *usea = xfx_ubar / (*x);
        *dsea = xfx_dbar / (*x);
        *str = xfx_s / (*x);
        *chm = xfx_c / (*x);
        *bot = xfx_b / (*x);
        *top = xfx_t / (*x);
        *gl = xfx_glu / (*x);
    } else {
        *upv = 0.0;
        *dnv = 0.0;
        *usea = 0.0;
        *dsea = 0.0;
        *str = 0.0;
        *chm = 0.0;
        *bot = 0.0;
        *top = 0.0;
        *gl = 0.0;
    }
}

/**
 * Cleanup LHAPDF
 */
void lhapdf_cleanup_() {
    if (current_pdf) {
        delete current_pdf;
        current_pdf = nullptr;
        current_pdfname = "";
    }
}

} // extern "C"

#else // !USE_LHAPDF

// Fallback implementation using built-in simple PDF when LHAPDF is not available
extern "C" {

// Forward declaration of Fortran simple PDF function
void simplepdf_getpdfs_(double* x, double* q, double* upv, double* dnv,
                        double* usea, double* dsea, double* str, double* chm,
                        double* bot, double* top, double* gl);

void lhapdf_initpdf_(const char* pdfname, int len) {
    std::cout << "NOTE: LHAPDF not available, using built-in simple PDF parameterization" << std::endl;
    std::cout << "For production runs, please install LHAPDF6 for more accurate PDFs" << std::endl;
}

void lhapdf_getpdfs_(double* x, double* q, double* upv, double* dnv,
                     double* usea, double* dsea, double* str, double* chm,
                     double* bot, double* top, double* gl) {
    // Call the Fortran simple PDF implementation
    simplepdf_getpdfs_(x, q, upv, dnv, usea, dsea, str, chm, bot, top, gl);
}

void lhapdf_cleanup_() {
}

} // extern "C"

#endif // USE_LHAPDF
