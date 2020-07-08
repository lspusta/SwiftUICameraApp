//
//  ContentView.swift
//  SwiftUICameraApp
//
//  Created by Lucas Spusta on 7/6/20.
//

import SwiftUI

struct CaptureImageView {
  
  /// MARK: - Properties
  @Binding var isShown: Bool
  @Binding var image: Image?

  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
  }
}

extension CaptureImageView: UIViewControllerRepresentable {
  func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    /// Default is images gallery. Un-comment the next line of code if you would like to test camera
    picker.sourceType = .camera
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<CaptureImageView>) {
    
  }
}

struct ExisitingCaptureImageView {
  
  /// MARK: - Properties
  @Binding var isShown: Bool
  @Binding var image: Image?

  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
  }
}

extension ExisitingCaptureImageView: UIViewControllerRepresentable {
  func makeUIViewController(context: UIViewControllerRepresentableContext<ExisitingCaptureImageView>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    /// Default is images gallery. Un-comment the next line of code if you would like to test camera
    //picker.sourceType = .camera
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<ExisitingCaptureImageView>) {
    
  }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(5.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
          
    }
}

struct ContentView: View {
    @State var image: Image? = nil
    @State var showCaptureImage: Bool = false
    @State var showCaptureExistingImage: Bool = false
    @State private var showingSheet = false
    
    var body: some View {
        ZStack {
          VStack {
            Button(action: {
                self.showingSheet = true
            }) {
              Text("Open Pop-Up")
            }.buttonStyle(GradientButtonStyle())
          
            .actionSheet(isPresented: $showingSheet) {
                   ActionSheet(title: Text("What do you want to do?"), message: Text("There's only one choice..."), buttons: [
                            .default(Text("Take Photo")){
                                self.showCaptureImage.toggle()
                            },
                            .default(Text("Choose Photo")){
                                self.showCaptureExistingImage.toggle()
                            },
                            .default(Text("Capture Video")){
                               
                            },
                            .cancel(Text("Cancel"))
                   ]
                   )
               }
            image?.resizable()
              .frame(width: 250, height: 200)
              .clipShape(Circle())
              .shadow(radius: 10)
          }
           if (showCaptureImage) {
             CaptureImageView(isShown: $showCaptureImage, image: $image)
           }
            
            if (showCaptureExistingImage) {
                ExisitingCaptureImageView(isShown: $showCaptureExistingImage, image: $image)
            }
        }
      }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
