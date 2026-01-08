import React from 'react';
import { Heart, HelpCircle, Calculator, FileText, Truck } from 'lucide-react';
import { useCOAPageSetting } from '../hooks/useCOAPageSetting';

const Footer: React.FC = () => {
  const currentYear = new Date().getFullYear();
  const { coaPageEnabled } = useCOAPageSetting();

  return (
    <footer className="bg-deep-blue-500 pt-16 pb-8">
      <div className="container mx-auto px-4">
        <div className="flex flex-col md:flex-row items-center justify-between gap-8 mb-10">

          {/* Brand Section - Logo Only */}
          <div className="flex items-center">
            <div className="h-12 md:h-14 bg-white rounded-lg p-2">
              <img
                src="/assets/logo.jpg"
                alt="SLIMMETRY"
                className="h-full w-auto object-contain"
              />
            </div>
          </div>

          {/* Quick Links */}
          <div className="flex flex-wrap items-center gap-4 justify-center md:justify-end">
            <a
              href="/track-order"
              className="text-teal-200 hover:text-white transition-colors flex items-center gap-2 text-sm font-medium"
            >
              <Truck className="w-4 h-4" />
              Track
            </a>
            <a
              href="/calculator"
              className="text-teal-200 hover:text-white transition-colors flex items-center gap-2 text-sm font-medium"
            >
              <Calculator className="w-4 h-4" />
              Calculator
            </a>
            {coaPageEnabled && (
              <a
                href="/coa"
                className="text-teal-200 hover:text-white transition-colors flex items-center gap-2 text-sm font-medium"
              >
                <FileText className="w-4 h-4" />
                Lab Tests
              </a>
            )}
            <a
              href="/faq"
              className="text-teal-200 hover:text-white transition-colors flex items-center gap-2 text-sm font-medium"
            >
              <HelpCircle className="w-4 h-4" />
              FAQ
            </a>

          </div>
        </div>

        {/* Divider */}
        <div className="h-px bg-gradient-to-r from-transparent via-teal-400/30 to-transparent mb-6" />

        {/* Locations */}
        <div className="text-center mb-6">
          <p className="text-xs text-teal-200/80 font-medium mb-2">📍 Our Locations</p>
          <div className="flex flex-col md:flex-row items-center justify-center gap-2 md:gap-6">
            <span className="text-xs text-teal-200/60">Mandaluyong, Metro Manila</span>
            <span className="hidden md:inline text-teal-200/40">•</span>
            <span className="text-xs text-teal-200/60">Bajada, Davao City</span>
          </div>
        </div>

        {/* Footer Bottom */}
        <div className="text-center">
          <p className="text-xs text-teal-200/60 flex items-center justify-center gap-1">
            Made with
            <Heart className="w-3 h-3 text-leaf-green-400 fill-leaf-green-400" />
            © {currentYear} SLIMMETRY. All rights reserved.
          </p>
          <p className="text-xs text-teal-200/40 mt-2">
            Science-guided weight and metabolic support for real-life wellness.
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
