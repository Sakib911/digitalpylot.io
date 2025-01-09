"use client";

import { Settings2, Phone, Mail, MapPin, Globe } from "lucide-react";
import { motion } from "framer-motion";
import Image from "next/image";

export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-[#F6F8FD] to-[#E2E8F0] flex items-center justify-center p-2">
      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="max-w-2xl w-full"
      >
        <div className="bg-white/80 backdrop-blur-lg rounded-3xl shadow-[0_20px_50px_rgba(8,_112,_184,_0.1)] p-8 md:p-12 space-y-8 border border-white/20">
          <div className="flex flex-col items-center text-center space-y-6">
            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ duration: 0.5 }}
            >
              <Image
                src="/logo.png"
                alt="Digital Pylot Logo"
                width={120}
                height={120}
                className="mb-4"
                priority
              />
            </motion.div>
            
            <motion.div
              animate={{ rotate: 360 }}
              transition={{ duration: 2, repeat: Infinity, ease: "linear" }}
              className="bg-gradient-to-r from-[#5927E5] to-[#60016E] p-4 rounded-2xl"
            >
              <Settings2 className="w-12 h-12 text-white" />
            </motion.div>
            
            <div className="space-y-3">
              <h1 className="text-4xl md:text-5xl font-bold text-[#60016E]">
                Site <span className="text-[#5927E5]">Under Maintenance </span> 
              </h1>
              
              <p className="text-[20px] text-gray-600 max-w-md mx-auto leading-relaxed">
                Digital Pylot is currently undergoing scheduled maintenance to enhance your experience. 
                We'll be back online shortly with improved features and performance.
              </p>
            </div>
          </div>

          <div className="space-y-6">
            <div className="bg-gradient-to-r from-[#F8F9FD] to-[#F1F4F9] p-6 rounded-2xl border border-white text-center">
              <p className="text-gray-600">
                Expected completion time:
                <span className="font-semibold ml-2 text-[#5927E5] text-center">
                  To Be Announced
                </span>
              </p>
            </div>

            {/* Contact Information Section */}
            <div className="grid md:grid-cols-2 gap-4">
              <div className="bg-white/50 p-4 rounded-xl border border-white flex items-center space-x-3">
                <Phone className="w-7 h-7 text-[#5927E5]" />
                <div className="text-left">
                  <p className="text-sm text-gray-500">Phone</p>
                  <a href="tel:+8801806972825" className="text-gray-700 hover:text-[#5927E5]">+880 1806 972825</a>
                </div>
              </div>
              
              <div className="bg-white/50 p-4 rounded-xl border border-white flex items-center space-x-3">
                <Mail className="w-7 h-7 text-[#5927E5]" />
                <div className="text-left">
                  <p className="text-sm text-gray-500">Email</p>
                  <a href="mailto:info@digitalpylot.io" className="text-gray-700 hover:text-[#5927E5]">info@digitalpylot.io</a>
                </div>
              </div>
              
              <div className="bg-white/50 p-4 rounded-xl border border-white flex items-center space-x-3">
                <MapPin className="w-7 h-7 text-[#5927E5]" />
                <div className="text-left">
                  <p className="text-sm text-gray-500">Address</p>
                  <address className="text-gray-700 not-italic">Road No-102, House-47, <br />Khilkhet, Dhaka-1229,<br /> Bangladesh</address>
                </div>
              </div>
              
              <div className="bg-white/50 p-4 rounded-xl border border-white flex items-center space-x-3">
                <Globe className="w-7 h-7 text-[#5927E5]" />
                <div className="text-left">
                  <p className="text-sm text-gray-500">Website</p>
                  <a href="https://digitalpylot.io" className="text-gray-700 hover:text-[#5927E5]">digitalpylot.io</a>
                </div>
              </div>
            </div>

        
          </div>
        </div>
      </motion.div>
    </div>
  );
}