
import { NativeModules } from 'react-native';
const RNClassExists = NativeModules.RNClassExists

export default class ClassExists {
	static exists(className, callback) {
    RNClassExists.exists(className, (doesExist)=>{
			callback(doesExist)
		})
  }

	static classMethodResponse(className, methodName, responseType, callback) {
		RNClassExists.classMethodResponse(className, methodName, responseType, (success, response)=>{
			callback(success, response)
		})
	}
}
