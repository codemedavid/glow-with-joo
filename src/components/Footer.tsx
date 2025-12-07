import React from 'react';
import { MessageCircle, Shield, Heart, Instagram, Phone } from 'lucide-react';
import { useCOAPageSetting } from '../hooks/useCOAPageSetting';

const Footer: React.FC = () => {
  const currentYear = new Date().getFullYear();
  const { coaPageEnabled } = useCOAPageSetting();

  // Contact Links
  const messengerMessage = encodeURIComponent('Hi! I would like to inquire about your products.');
  const messengerUrl = `https://m.me/renalyndv?text=${messengerMessage}`;
  const instagramUrl = 'https://www.instagram.com/hpglowpeptides';
  const viberUrl = `tel:+639062349763`; // Opens phone/Viber on mobile devices

  return (
    <footer className="bg-white border-t border-gray-100 pt-12 pb-6">
      <div className="container mx-auto px-4">
        <div className="flex flex-col md:flex-row items-center justify-between gap-8 mb-8">

          {/* Brand Section */}
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full overflow-hidden border border-gray-100">
              <img
                src="/assets/logo.jpg"
                alt="HP GLOW"
                className="w-full h-full object-cover"
              />
            </div>
            <div className="text-left">
              <div className="font-bold text-theme-text text-lg tracking-tight">
                HP GLOW
              </div>
              <div className="text-xs text-gray-500">Premium Peptides</div>
            </div>
          </div>

          {/* Quick Links */}
          <div className="flex flex-wrap items-center gap-4 justify-center md:justify-end">
            {coaPageEnabled && (
              <a
                href="/coa"
                className="flex items-center gap-2 text-gray-600 hover:text-theme-accent transition-colors text-sm font-medium"
              >
                <Shield className="w-4 h-4" />
                <span>Lab Reports</span>
              </a>
            )}
            <a
              href={instagramUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 text-gray-600 hover:text-theme-accent transition-colors text-sm font-medium"
            >
              <Instagram className="w-4 h-4" />
              <span>Instagram</span>
            </a>
            <a
              href={viberUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 text-gray-600 hover:text-theme-accent transition-colors text-sm font-medium"
            >
              <Phone className="w-4 h-4" />
              <span>Viber</span>
            </a>
            <a
              href={messengerUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-2 text-gray-600 hover:text-theme-accent transition-colors text-sm font-medium"
            >
              <MessageCircle className="w-4 h-4" />
              <span>Messenger</span>
            </a>
          </div>

        </div>

        {/* Footer Bottom */}
        <div className="border-t border-gray-100 pt-6 text-center">
          <p className="text-xs text-gray-400 flex items-center justify-center gap-1">
            Made with
            <Heart className="w-3 h-3 text-theme-secondary fill-theme-secondary" />
            © {currentYear} HP GLOW.
          </p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
