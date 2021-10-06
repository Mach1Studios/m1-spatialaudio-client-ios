import SwiftUI

struct PlaybackStatusView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: Constants.Image.System.PreviousTrack.rawValue)
                    .resizable()
                    .frame(width: Constants.Image.Dimension.Small.rawValue, height: Constants.Image.Dimension.Small.rawValue)
                    .foregroundColor(.Mach1Gray)
                Spacer()
                Image(systemName: Constants.Image.System.PlayTrack.rawValue)
                    .resizable()
                    .frame(width: Constants.Image.Dimension.Normal.rawValue, height: Constants.Image.Dimension.Normal.rawValue)
                    .foregroundColor(.Mach1Gray)
                Spacer()
                Image(systemName: Constants.Image.System.NextTrack.rawValue)
                    .resizable()
                    .frame(width: Constants.Image.Dimension.Small.rawValue, height: Constants.Image.Dimension.Small.rawValue)
                    .foregroundColor(.Mach1Gray)
            }
            
            VStack(spacing: Mach1Margin.VSmall.rawValue) {
                HStack {
                    Text("3:25").foregroundColor(.Mach1Yellow).textStyle(SmallBodyStyle())
                    VLine()
                        .stroke(lineWidth: Constants.LineWidth.normal)
                        .foregroundColor(.Mach1Yellow)
                        .frame(width: Constants.LineWidth.normal, height: 30)
                    Text("8:07").foregroundColor(.Mach1Gray).textStyle(SmallBodyStyle())
                }
                HStack(spacing: 0) {
                    HStack() {
                        Spacer()
                    HLine()
                        .stroke(lineWidth: Constants.LineWidth.normal)
                        .foregroundColor(.Mach1Yellow)
                        .frame(width: 40, height: Constants.LineWidth.normal)
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    HStack {
                        HLine()
                            .stroke(lineWidth: Constants.LineWidth.normal)
                            .foregroundColor(.Mach1GrayLight)
                            .frame(width: 70, height: Constants.LineWidth.normal)
                        Spacer()
                    }.frame(minWidth: 0, maxWidth: .infinity)
                }
            }.padding(.top, Mach1Margin.VBig.rawValue)
        }
    }
}

// MARK: Preview

struct PlaybackStatusView_Previews: PreviewProvider {
    static var previews: some View {
        Mach1View {
            PlaybackStatusView()
        }
    }
}
