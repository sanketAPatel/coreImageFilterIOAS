//
//  ViewController.swift
//  CoreImageFilterApp
//
//  Created by sanket on 2021-06-13.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    struct Filter {
        let filterName: String
        var filterEffectValue: Any?
        var filterEffectValueName: String?
        
        init(filterName: String, filterEffectValue: Any?, filterEffectValueName: String?){
            self.filterName = filterName
            self.filterEffectValue = filterEffectValue
            self.filterEffectValueName = filterEffectValueName
        }
    }
    
    @IBOutlet weak var Img: UIImageView!  //  @IBOutlet weak var Img: UIImageView!
    private var originalImage: UIImage?
    var isFiltered = false
    
    @IBOutlet weak var intensitySlider: UISlider!
    
  
 
    @IBOutlet weak var sepiaSlidertoneeffect: UISlider!
    @IBOutlet weak var sepiLebleSlider: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalImage = Img.image
        // Do any additional setup after loading the view.
    }
    
 //slier function here
    
    private func applyFilters(image: UIImage, filterEffect: Filter) -> UIImage? {
        guard let cgImage = image.cgImage,
              let openGLContext = EAGLContext(api: .openGLES3)
        else {
                return nil
              }
        let context = CIContext(eaglContext: openGLContext)
        let ciImage = CIImage(cgImage: cgImage)
        let filter = CIFilter(name: filterEffect.filterName)
        
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        if let filterEffectValue = filterEffect.filterEffectValue,
           let filterEffectValueName = filterEffect.filterEffectValueName {
            filter?.setValue(filterEffectValue, forKey: filterEffectValueName)
        }
        var filteredImage: UIImage?
        
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage,
           let cgiImageResult = context.createCGImage(output, from: output.extent){
            filteredImage = UIImage(cgImage: cgiImageResult)
        }
        return filteredImage
    }
    
    

    
    @IBAction func commicEffect(_ sender: UIButton)
    {
        guard let image = Img.image
        
        else {
            return
        }
        Img.image = applyFilters(image: image, filterEffect: Filter(filterName: "CIComicEffect", filterEffectValue: nil, filterEffectValueName: kCIInputImageKey))
    }
    
  
    
    @IBAction func xrayEffect(_ sender: UIButton)
    {
        guard let image = Img.image else {
            return
        }
        Img.image = applyFilters(image: image, filterEffect: Filter(filterName: "CIXRay", filterEffectValue: nil, filterEffectValueName: kCIInputImageKey))
        
    }
    
   
    @IBAction func btnThermal(_ sender: UIButton)
    {
        guard let image = Img.image else {
            return
        }
        Img.image = applyFilters(image: image, filterEffect: Filter(filterName: "CIThermal", filterEffectValue: nil, filterEffectValueName: kCIInputAngleKey))
            
    }
    
   
    @IBAction func btnInvert(_ sender: UIButton) {
        guard let image = Img.image else {
            return
        }
        Img.image = applyFilters(image: image, filterEffect: Filter(filterName: "CIColorInvert", filterEffectValue: nil, filterEffectValueName: kCIInputAngleKey))
                }
    
    
    @IBAction func btnNoirEffect(_ sender: UIButton) {
        
        guard let image = Img.image else {
            return
        }
        Img.image = applyFilters(image: image, filterEffect: Filter(filterName: "CIPhotoEffectNoir", filterEffectValue: nil, filterEffectValueName: kCIInputAngleKey))
    }
    
    
    @IBAction func sepiaSlidertoneeffect(_ sender: UISlider) {
      //  sepiLebleSlider
        sepiaSlidertoneeffect.maximumValue = 10
        sepiaSlidertoneeffect.minimumValue = 0
        let currentValue = Int((sender.value).rounded())
        sepiLebleSlider.text = String(currentValue)


        guard let image = Img.image else {
            return
        }
        Img.image = applyFilters(image: image, filterEffect: Filter(filterName: "CISepiaTone", filterEffectValue: currentValue, filterEffectValueName: kCIInputIntensityKey))
        
        
    }
    
    @IBAction func clearFilter(_ sender: UIButton) {
        Img.image = originalImage
        
    }
}
