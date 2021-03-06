#ifndef PhotonsWithConversionsAnalyzer_H
#define PhotonsWithConversionsAnalyzer_H
#include "RecoEgamma/EgammaMCTools/interface/PhotonMCTruthFinder.h"

#include "Geometry/TrackerGeometryBuilder/interface/TrackerGeometry.h"
#include "FWCore/Framework/interface/EDAnalyzer.h"

#include <map>
#include <vector>


// forward declarations
class TFile;
class TH1F;
class TH2F;
class TProfile;
class TTree;
class SimVertex;
class SimTrack;


class PhotonsWithConversionsAnalyzer : public edm::EDAnalyzer
{

   public:
   
      //
      explicit PhotonsWithConversionsAnalyzer( const edm::ParameterSet& ) ;
      ~PhotonsWithConversionsAnalyzer() override;
                                   
      
      void analyze( const edm::Event&, const edm::EventSetup& ) override ;
      void beginJob() override ;
      void endJob() override ;

   private:

      float etaTransformation( float a, float b);

      
      //
      PhotonMCTruthFinder*  thePhotonMCTruthFinder_;
      
      std::string fOutputFileName_ ;
      TFile*      fOutputFile_ ;
      
      
      int nEvt_;
      int nMCPho_;
      int nMatched_;
      
      std::string HepMCLabel;
      std::string SimTkLabel;
      std::string SimVtxLabel;
      std::string SimHitLabel;
      
           
     std::string photonCollectionProducer_;       
     std::string photonCollection_;

     TH1F *h_ErecoEMC_;
     TH1F *h_deltaPhi_;
     TH1F *h_deltaEta_;


     //// All MC photons
     TH1F *h_MCphoE_;
     TH1F *h_MCphoPhi_;
     TH1F *h_MCphoEta_;



     //// visible MC Converted photons
     TH1F *h_MCConvE_;
     TH1F *h_MCConvPt_;
     TH1F *h_MCConvEta_;


     // SC from reco photons
     TH1F* h_scE_;
     TH1F* h_scEt_;
     TH1F* h_scEta_;
     TH1F* h_scPhi_;
     //
     TH1F* h_phoE_;
     TH1F* h_phoEta_;
     TH1F* h_phoPhi_;
     //
     // All tracks from reco photons
     TH2F* h2_tk_nHitsVsR_;
     //
     TH2F* h2_tk_inPtVsR_;





};

#endif
