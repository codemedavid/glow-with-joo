import React from 'react';
import { ArrowRight, ShieldCheck, Sparkles } from 'lucide-react';

const Hero: React.FC = () => {
  return (
    <div className="relative overflow-hidden bg-theme-bg pt-12 pb-16 md:pt-20 md:pb-24 lg:pt-28 lg:pb-32">
      {/* Abstract Background Shape */}
      <div className="absolute top-0 right-0 -mr-24 -mt-24 w-96 h-96 rounded-full bg-theme-accent/5 blur-3xl opacity-50 pointer-events-none" />
      <div className="absolute bottom-0 left-0 -ml-24 -mb-24 w-80 h-80 rounded-full bg-theme-secondary/5 blur-3xl opacity-50 pointer-events-none" />

      <div className="container mx-auto px-4 relative z-10">
        <div className="max-w-4xl mx-auto text-center">

          {/* Badge */}
          <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-white border border-gray-100 shadow-sm mb-6 md:mb-8 animate-fadeIn">
            <span className="relative flex h-2 w-2">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-theme-secondary opacity-75"></span>
              <span className="relative inline-flex rounded-full h-2 w-2 bg-theme-secondary"></span>
            </span>
            <span className="text-xs md:text-sm font-medium text-gray-600 tracking-wide">
              Premium Peptide Solutions
            </span>
          </div>

          {/* Main Heading */}
          <h1 className="text-4xl md:text-5xl lg:text-7xl font-bold text-theme-text mb-6 md:mb-8 tracking-tight leading-tight">
            Radiance, <span className="text-theme-accent">Confidence</span> <br className="hidden md:block" />
            & Vitality.
          </h1>

          {/* Subheading */}
          <p className="text-lg md:text-xl text-gray-500 mb-8 md:mb-12 max-w-2xl mx-auto leading-relaxed">
            Discover a curated selection of premium peptides designed to help you look and feel your absolute best. Lab-verified purity tailored for your journey.
          </p>

          {/* CTA Buttons */}
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 mb-12 md:mb-16">
            <button className="btn-primary w-full sm:w-auto group flex items-center justify-center gap-2">
              Shop Collection
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </button>
            <button className="px-8 py-3 rounded-lg font-medium text-theme-text hover:text-theme-accent transition-colors flex items-center gap-2 w-full sm:w-auto justify-center">
              View Lab Reports
              <ShieldCheck className="w-4 h-4" />
            </button>
          </div>

          {/* Trust Indicators */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-6 md:gap-12 border-t border-gray-100 pt-8 md:pt-12 max-w-3xl mx-auto">
            <div className="flex flex-col items-center gap-2 group">
              <div className="p-3 bg-white rounded-xl shadow-sm border border-gray-100 group-hover:border-theme-accent/30 transition-colors">
                <ShieldCheck className="w-6 h-6 text-theme-accent" />
              </div>
              <p className="font-semibold text-theme-text">Lab Verified</p>
              <p className="text-sm text-gray-400">99% Purity Guaranteed</p>
            </div>
            <div className="flex flex-col items-center gap-2 group">
              <div className="p-3 bg-white rounded-xl shadow-sm border border-gray-100 group-hover:border-theme-secondary/30 transition-colors">
                <Sparkles className="w-6 h-6 text-theme-secondary" />
              </div>
              <p className="font-semibold text-theme-text">Premium Quality</p>
              <p className="text-sm text-gray-400">Sourced for Excellence</p>
            </div>
            <div className="flex flex-col items-center gap-2 group">
              <div className="p-3 bg-white rounded-xl shadow-sm border border-gray-100 group-hover:border-theme-accent/30 transition-colors">
                <div className="w-6 h-6 rounded-full bg-gradient-to-tr from-theme-accent to-theme-secondary opacity-75" />
              </div>
              <p className="font-semibold text-theme-text">Fast Shipping</p>
              <p className="text-sm text-gray-400">Nationwide Delivery</p>
            </div>
          </div>

        </div>
      </div>
    </div>
  );
};

export default Hero;
