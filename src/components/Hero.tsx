import React, { useEffect, useState } from 'react';
import { ArrowRight, Shield, ChevronRight, Beaker, Dna, Award, Zap } from 'lucide-react';
import { useCOAPageSetting } from '../hooks/useCOAPageSetting';

interface HeroProps {
  onShopAll: () => void;
}

const Hero: React.FC<HeroProps> = ({ onShopAll }) => {
  const [isVisible, setIsVisible] = useState(false);
  const { coaPageEnabled } = useCOAPageSetting();

  useEffect(() => {
    setIsVisible(true);
  }, []);

  return (
    <div className="relative min-h-[85vh] sm:min-h-[90vh] overflow-hidden flex items-center bg-white">
      {/* Subtle Background Design */}
      <div className="absolute inset-0 z-0">
        {/* Gradient Orbs */}
        <div className="absolute top-0 right-0 w-[600px] h-[600px] bg-gradient-to-bl from-clinical-blue/40 via-tech-teal/10 to-transparent rounded-full blur-3xl -translate-y-1/4 translate-x-1/4" />
        <div className="absolute bottom-0 left-0 w-[500px] h-[500px] bg-gradient-to-tr from-bio-green/10 via-clinical-blue/20 to-transparent rounded-full blur-3xl translate-y-1/4 -translate-x-1/4" />

        {/* Subtle Grid Pattern */}
        <div className="absolute inset-0 bg-[linear-gradient(rgba(13,59,102,0.02)_1px,transparent_1px),linear-gradient(90deg,rgba(13,59,102,0.02)_1px,transparent_1px)] bg-[size:50px_50px]" />

        {/* DNA Helix - Left Side */}
        <div className="hidden lg:block absolute left-[3%] top-1/2 -translate-y-1/2 w-16 h-[500px] opacity-[0.08]">
          <svg viewBox="0 0 100 600" className="w-full h-full" preserveAspectRatio="none">
            {[...Array(12)].map((_, i) => (
              <g key={i}>
                <circle cx={50 + Math.sin(i * 0.5) * 30} cy={i * 50 + 25} r="6" fill="#0D3B66" />
                <circle cx={50 - Math.sin(i * 0.5) * 30} cy={i * 50 + 25} r="6" fill="#1FA6A3" />
                <line
                  x1={50 + Math.sin(i * 0.5) * 30} y1={i * 50 + 25}
                  x2={50 - Math.sin(i * 0.5) * 30} y2={i * 50 + 25}
                  stroke="#0D3B66" strokeWidth="2" opacity="0.5"
                />
              </g>
            ))}
          </svg>
        </div>

        {/* DNA Helix - Right Side */}
        <div className="hidden lg:block absolute right-[3%] top-1/2 -translate-y-1/2 w-16 h-[500px] opacity-[0.08]">
          <svg viewBox="0 0 100 600" className="w-full h-full" preserveAspectRatio="none">
            {[...Array(12)].map((_, i) => (
              <g key={i}>
                <circle cx={50 + Math.cos(i * 0.5) * 30} cy={i * 50 + 25} r="6" fill="#1FA6A3" />
                <circle cx={50 - Math.cos(i * 0.5) * 30} cy={i * 50 + 25} r="6" fill="#6CBF4A" />
                <line
                  x1={50 + Math.cos(i * 0.5) * 30} y1={i * 50 + 25}
                  x2={50 - Math.cos(i * 0.5) * 30} y2={i * 50 + 25}
                  stroke="#1FA6A3" strokeWidth="2" opacity="0.5"
                />
              </g>
            ))}
          </svg>
        </div>

        {/* Decorative Circles */}
        <div className="absolute top-20 right-[15%] w-64 h-64 border border-science-blue-100 rounded-full opacity-30" />
        <div className="absolute top-32 right-[12%] w-48 h-48 border border-tech-teal/20 rounded-full opacity-40" />
        <div className="absolute bottom-20 left-[10%] w-32 h-32 border border-bio-green/20 rounded-full opacity-30" />
      </div>

      {/* Main Content */}
      <div className="relative z-10 container mx-auto px-4 sm:px-6 lg:px-8 py-16 lg:py-24">
        <div className="max-w-4xl mx-auto text-center lg:text-left lg:mx-0">

          {/* Badge */}
          <div
            className={`inline-flex items-center gap-3 px-5 py-2.5 rounded-full bg-clinical-blue border border-science-blue-100 mb-8 transition-all duration-700 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
              }`}
          >
            <div className="w-2 h-2 bg-bio-green rounded-full animate-pulse" />
            <span className="text-xs font-bold text-science-blue-800 uppercase tracking-[0.15em]">Research-Grade Peptide Science</span>
            <Beaker className="w-4 h-4 text-tech-teal" />
          </div>

          {/* Headline */}
          <h1
            className={`font-heading text-4xl sm:text-5xl md:text-6xl lg:text-7xl font-bold text-science-blue-900 tracking-tight leading-[1.05] mb-8 transition-all duration-700 delay-100 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
              }`}
          >
            Precision Peptides.
            <br />
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-tech-teal to-bio-green">
              Pure Science.
            </span>
          </h1>

          {/* Subheadline */}
          <p
            className={`text-lg md:text-xl text-gray-600 max-w-2xl mb-10 leading-relaxed font-sans mx-auto lg:mx-0 transition-all duration-700 delay-200 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
              }`}
          >
            HPLC-verified, third-party tested peptides for labs, clinicians, and educated researchers.
            No fluff—just <span className="text-science-blue-900 font-semibold">99%+ purity</span> and uncompromising transparency.
          </p>

          {/* CTA Buttons */}
          <div
            className={`flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-4 mb-16 transition-all duration-700 delay-300 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
              }`}
          >
            <button
              onClick={onShopAll}
              className="w-full sm:w-auto group relative px-8 py-4 bg-science-blue-900 text-white font-bold rounded-lg shadow-lg shadow-science-blue-900/20 hover:shadow-xl hover:bg-science-blue-800 transition-all duration-300 flex items-center justify-center gap-3"
            >
              <span>Explore Catalog</span>
              <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
            </button>

            {coaPageEnabled && (
              <a
                href="/coa"
                className="w-full sm:w-auto px-8 py-4 bg-white text-science-blue-900 font-semibold rounded-lg border-2 border-science-blue-100 hover:border-tech-teal hover:bg-clinical-blue/50 transition-all duration-300 flex items-center justify-center gap-3"
              >
                <Shield className="w-5 h-5 text-tech-teal" />
                View Lab Reports
                <ChevronRight className="w-4 h-4" />
              </a>
            )}
          </div>

          {/* Trust Stats Bar */}
          <div
            className={`flex flex-wrap items-center justify-center lg:justify-start gap-6 sm:gap-8 lg:gap-12 transition-all duration-700 delay-500 ${isVisible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
              }`}
          >
            {[
              { icon: Dna, value: '99%+', label: 'Purity Verified' },
              { icon: Award, value: '500+', label: 'Orders Shipped' },
              { icon: Zap, value: '24hr', label: 'Fast Processing' }
            ].map((stat, idx) => (
              <div key={idx} className="flex items-center gap-2 sm:gap-3 group">
                <div className="p-2 sm:p-2.5 rounded-xl bg-clinical-blue border border-science-blue-100 group-hover:border-tech-teal/50 group-hover:bg-tech-teal/10 transition-colors">
                  <stat.icon className="w-4 h-4 sm:w-5 sm:h-5 text-tech-teal" />
                </div>
                <div>
                  <p className="text-xl sm:text-2xl font-bold text-science-blue-900">{stat.value}</p>
                  <p className="text-[10px] sm:text-xs text-gray-500 uppercase tracking-wider">{stat.label}</p>
                </div>
              </div>
            ))}
          </div>

        </div>
      </div>
    </div>
  );
};

export default Hero;
